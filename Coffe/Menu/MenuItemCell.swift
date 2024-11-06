import UIKit
import SnapKit
import AlamofireImage

class MenuItemCell: UICollectionViewCell {
    
    static let identifier = "MenuItemCell"
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.ColorText
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .brown
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0"
        label.textAlignment = .center
        label.textColor = UIColor.ColorText
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("–", for: .normal)
        button.setTitleColor(UIColor.ColorText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.ColorText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(plusButton)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = false
        
        itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(137)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        minusButton.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(16)
            make.centerY.equalTo(priceLabel)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(minusButton.snp.trailing).offset(8)
            make.centerY.equalTo(priceLabel)
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(quantityLabel.snp.trailing).offset(8)
            make.centerY.equalTo(priceLabel)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupActions() {
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    @objc private func didTapMinusButton() {
        onRemoveFromCartTapped?()
    }
    
    var onAddToCartTapped: (() -> Void)?
    var onRemoveFromCartTapped: (() -> Void)?
    
    
    @objc private func didTapPlusButton() {
        onAddToCartTapped?()
    }
    
    func configure(with item: MenuItem) {
        nameLabel.text = item.name
        priceLabel.text = "\(item.price) руб"
        quantityLabel.text = "\(item.quality ?? 0)"
        
        if let url = URL(string: item.imageURL) {
            itemImageView.af.setImage(withURL: url)
        } else {
            itemImageView.image = nil
        }
    }
}
