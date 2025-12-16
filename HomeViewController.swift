//
//  ViewController.swift
//  NASA_APOD
//
//  Created by Shrikrishna Thodsare on 15/12/25.
//

import UIKit

class HomeViewController: UIViewController {

    private let backgroundGradient = CAGradientLayer()
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var earthImageView: UIImageView!
    
    
    
    // MARK: - ViewModel
    private let viewModel = APODViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.isHidden = true
        imageView.alpha = 0.5
        titleLabel.alpha = 0.5
        descriptionTextView.alpha = 0.5
        setupDatePicker()
        bindViewModel()
        viewModel.fetchAPOD(for: nil) // Fetch today's APOD
        showLoader()
        hideLoader()
        animateContent()
        setupGalaxyBackground()
        addStarField()
        startEarthRotation()
        addPlanetGlow()
        addParallaxToEarth()
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = view.bounds
    }

    
    // MARK: - Date Picker Setup
    func setupDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.minimumDate = formatter.date(from: "1995-06-16")
        datePicker.maximumDate = Date()
    }
    
    func showLoader() {
        loader.startAnimating()
        loader.isHidden = false
    }
    
    
    func bindViewModel() {
       
        viewModel.onSuccess = { [weak self] in
            self?.hideLoader()
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.hideLoader()
            print("API Error:", error)
        }
    }
    
    // MARK: - Update UI
    func updateUI() {
        guard let apod = viewModel.apod else { return }
        
        titleLabel.text = apod.title
        dateLabel.text = apod.date
        descriptionTextView.text = apod.explanation
        
        if apod.media_type == "image" {
            loadImage(from: apod.url)
        } else {
            imageView.image = nil
        }
    }
    
    // MARK: - Image Loader
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    // MARK: - Date Change Action
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: sender.date)
        
        viewModel.fetchAPOD(for: selectedDate)
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        
    }
    
    

    func animateContent() {
        imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0.1,
            options: [.curveEaseInOut],
            animations: {
                self.imageView.alpha = 1
                self.titleLabel.alpha = 1
                self.descriptionTextView.alpha = 1
                self.dateLabel.alpha = 1
                self.imageView.transform = .identity
            }
        )
    }
    
    func setupGalaxyBackground() {
        backgroundGradient.frame = view.bounds
        backgroundGradient.colors = [
            UIColor(red: 5/255, green: 5/255, blue: 25/255, alpha: 1).cgColor,
            UIColor(red: 25/255, green: 10/255, blue: 60/255, alpha: 1).cgColor,
            UIColor(red: 10/255, green: 20/255, blue: 80/255, alpha: 1).cgColor
        ]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(backgroundGradient, at: 0)
        animateGalaxyGradient()
    }
    
    func animateGalaxyGradient() {
        let anim = CABasicAnimation(keyPath: "colors")
        anim.fromValue = backgroundGradient.colors
        anim.toValue = [
            UIColor(red: 10/255, green: 20/255, blue: 80/255, alpha: 1).cgColor,
            UIColor(red: 40/255, green: 15/255, blue: 90/255, alpha: 1).cgColor,
            UIColor(red: 5/255, green: 5/255, blue: 25/255, alpha: 1).cgColor
        ]
        anim.duration = 25
        anim.autoreverses = true
        anim.repeatCount = .infinity
        backgroundGradient.add(anim, forKey: "galaxyGradient")
    }
    
    func addStarField() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: -50)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        
        let star = CAEmitterCell()
        star.contents = UIImage(systemName: "circle.fill")?.cgImage
        star.birthRate = 0.4
        star.lifetime = 60
        star.velocity = 15
        star.velocityRange = 10
        star.scale = 0.015
        star.scaleRange = 0.01
        star.alphaRange = 0.2
        star.alphaSpeed = -0.005
        star.color = UIColor.white.cgColor
        
        emitter.emitterCells = [star]
        view.layer.insertSublayer(emitter, above: backgroundGradient)
    }
    func startEarthRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 40     // slow = realistic
        rotation.repeatCount = .infinity
        rotation.isRemovedOnCompletion = false
        
        earthImageView.layer.add(rotation, forKey: "earthRotation")
    }
    func addPlanetGlow() {
        earthImageView.layer.shadowColor = UIColor.systemBlue.cgColor
        earthImageView.layer.shadowRadius = 20
        earthImageView.layer.shadowOpacity = 0.6
        earthImageView.layer.shadowOffset = .zero
    }
    func addParallaxToEarth() {
        let xMotion = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: .tiltAlongHorizontalAxis
        )
        xMotion.minimumRelativeValue = -20
        xMotion.maximumRelativeValue = 20
        
        let yMotion = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: .tiltAlongVerticalAxis
        )
        yMotion.minimumRelativeValue = -20
        yMotion.maximumRelativeValue = 20
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        earthImageView.addMotionEffect(group)
    }
    
}

