//
//  CustomSwitch.swift
//  CustomSwitch
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Admin. All rights reserved.


import UIKit

@IBDesignable
public class CustomSwitch: UIControl {
    
    // MARK: Public properties
    public var animationDelay: Double = 0
    public var animationSpriteWithDamping = CGFloat(0.7)
    public var initialSpringVelocity = CGFloat(0.5)
    public var animationOptions: UIView.AnimationOptions = [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction]
    
    @IBInspectable public var isOn:Bool = true
    
    public var animationDuration: Double = 0.5
    
    @IBInspectable  public var padding: CGFloat = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable  public var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var offTintColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        
        get {
            return self.privateCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
    }
    
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    // MARK: thumb properties
    @IBInspectable public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    @IBInspectable public var thumbCornerRadius: CGFloat {
        get {
            return self.privateThumbCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    @IBInspectable public var thumbSize: CGSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var thumbImage:UIImage? = nil {
        didSet {
            guard let image = thumbImage else {
                return
            }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var onImage:UIImage? {
        didSet {
            self.onImageView.image = onImage
            self.layoutSubviews()
            
        }
        
    }
    
    public var offImage:UIImage? {
        didSet {
            self.offImageView.image = offImage
            self.layoutSubviews()
        }
        
    }
    
    
    //
    @IBInspectable public var thumbShadowColor: UIColor = UIColor.black {
        didSet {
            self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        }
    }
    
    @IBInspectable public var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet {
            self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        }
    }
    
    @IBInspectable public var thumbShaddowRadius: CGFloat = 1.5 {
        didSet {
            self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        }
    }
    
    @IBInspectable public var thumbShaddowOppacity: Float = 0.4 {
        didSet {
            self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        }
    }
    
    // ...labels
    @IBInspectable public var thumbLabel:String? {
        didSet {
            guard let label = thumbLabel else {
                return
            }
            self.thumbView.thumbLabel.text = label
        }
    }
    
    @IBInspectable public var labelOff:String? {
        didSet {
            guard let label = labelOff else {
                return
            }
            self.lblOff.text = label
        }
    }
    
    @IBInspectable public var labelOn:String? {
        didSet {
            guard let label = labelOn else {
                return
            }
            self.lblOn.text = label
        }
    }
    
    @IBInspectable public var labelOnTextColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var labelOffTextColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var thumbLabelTextColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var labelFontSize: CGFloat = 12 {
        didSet{
            setupUI()
        }
    }
    
    public var areLabelsShown: Bool = true {
        didSet {
            self.setupUI()
        }
    }
    
    private var lblOff:UILabel = UILabel()
    private var lblOn:UILabel = UILabel()
    
    public var thumbView = CustomThumbView(frame: CGRect.zero)
    public var onImageView = UIImageView(frame: CGRect.zero)
    public var offImageView = UIImageView(frame: CGRect.zero)
    public var onPoint = CGPoint.zero
    public var offPoint = CGPoint.zero
    public var isAnimating = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
}

// MARK: Private methods
extension CustomSwitch {
    fileprivate func setupUI() {
        // clear self before configuration
        self.clear()
        
        self.clipsToBounds = false
        
        // configure thumb view
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        // dodati kasnije
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        
        self.addSubview(self.thumbView)
        self.addSubview(self.onImageView)
        self.addSubview(self.offImageView)
        
        self.setupLabels()
    }
    
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    func setOn(on:Bool, animated:Bool) {
        
        switch animated {
        case true:
            self.animate(on: on)
        case false:
            self.isOn = on
            self.setupViewsOnAction()
            self.completeAction()
        }
    }
    
    fileprivate func animate(on:Bool? = nil) {
        self.isOn = on ?? !self.isOn
        
        self.isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
            
        }, completion: { _ in
            self.completeAction()
        })
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.setOnOffImageFrame()
    }
    
    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControl.Event.valueChanged)
    }
    
}

// Mark: Public methods
extension CustomSwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            
            // thumb managment
            // get thumb size, if none set, use one from bounds
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.width/2, height: self.bounds.height - 2)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
            
            //label frame
            if self.areLabelsShown {
                let labelWidth = self.bounds.width / 2 - self.padding * 2
                self.lblOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
                self.lblOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            }
            
            // on/off images
            //set to preserve aspect ratio of image in thumbView
            
            guard onImage != nil && offImage != nil else {
                return
            }
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
            
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            
            self.onImageView.frame.size = onOffImageSize
            self.offImageView.frame.size = onOffImageSize
            
            self.onImageView.center = CGPoint(x: self.onPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            self.offImageView.center = CGPoint(x: self.offPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            
            
            self.onImageView.alpha = self.isOn ? 1.0 : 0.0
            self.offImageView.alpha = self.isOn ? 0.0 : 1.0
            
        }
    }
}

//Mark: Labels frame
extension CustomSwitch {
    
    fileprivate func setupLabels() {
        guard self.areLabelsShown else {
            self.lblOff.alpha = 0
            self.lblOn.alpha = 0
            return
        }
        
        self.lblOff.alpha = 1
        self.lblOn.alpha = 1
        
        let labelWidth = self.bounds.width / 2 - self.padding * 2
        self.lblOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        self.lblOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        self.lblOn.font = UIFont.systemFont(ofSize: labelFontSize)
        self.lblOff.font = UIFont.systemFont(ofSize: labelFontSize)
        self.thumbView.thumbLabel.font = UIFont.systemFont(ofSize: labelFontSize)
        self.lblOn.textColor = labelOnTextColor
        self.lblOff.textColor = labelOffTextColor
        self.thumbView.thumbLabel.textColor = thumbLabelTextColor
        
        self.lblOff.sizeToFit()
        self.lblOff.textAlignment = .center
        self.lblOn.textAlignment = .center
        self.thumbView.thumbLabel.textAlignment = .center
        
        self.insertSubview(self.lblOff, belowSubview: self.thumbView)
        self.insertSubview(self.lblOn, belowSubview: self.thumbView)
        
    }
    
}

//Mark: Animating on/off images
extension CustomSwitch {
    
    fileprivate func setOnOffImageFrame() {
        guard onImage != nil && offImage != nil else {
            return
        }
        
        self.onImageView.center.x = self.isOn ? self.onPoint.x + self.thumbView.frame.size.width / 2 : self.frame.width
        self.offImageView.center.x = !self.isOn ? self.offPoint.x + self.thumbView.frame.size.width / 2 : 0
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
    }
}




public final class CustomThumbView: UIView {
    
    fileprivate(set) var thumbImageView = UIImageView(frame: CGRect.zero)
    fileprivate(set) var thumbLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubview()
    }
    
    func initializeSubview(){
        self.addSubview(self.thumbLabel)
        self.addSubview(self.thumbImageView)
    }
}

extension CustomThumbView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.thumbImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.thumbImageView.layer.cornerRadius = self.layer.cornerRadius
        self.thumbImageView.clipsToBounds = self.clipsToBounds
        
        self.thumbLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.thumbLabel.layer.cornerRadius = self.layer.cornerRadius
        self.thumbLabel.clipsToBounds = self.clipsToBounds
    }
    
}
