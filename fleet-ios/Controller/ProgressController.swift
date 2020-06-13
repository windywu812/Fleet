import UIKit
import Charts

class ProgressController: UIViewController {
    
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateInfo: UIStackView!
    @IBOutlet weak var totalStepsWeekly: UILabel!
    @IBOutlet weak var weeklySummary: UILabel!
    @IBOutlet weak var infoProgress: UILabel!
    @IBOutlet weak var cardView: RoundedView!
    
    var isOnYear: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setChartWeekly()
        segmentControl.selectedSegmentIndex = 0
    }
    
    func addGestureToChart() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        swipeRight.direction = .right
        chartView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        swipeLeft.direction = .left
        chartView.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func swipeGesture(sender: UISwipeGestureRecognizer) {
        
        if isOnYear {
            switch sender.direction {
            case .right:
                setChartWeekly(-1)
            case .left:
                setChartWeekly(1)
            default:
                return
            }
        } else {
            return
        }
        
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isOnYear.toggle()
            setChartWeekly()
        } else if sender.selectedSegmentIndex == 1 {
            isOnYear.toggle()
            setChartAnually()
        }
    }
    
    func setupView() {
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        chartView.backgroundColor = .white
        addShadow(chartView)
        addShadow(cardView)
        setUpChart()
    }
    
    func addShadow(_ view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.03
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setUpChart() {
        
        barChart.delegate = self
        barChart.doubleTapToZoomEnabled = false
        view.addSubview(barChart)
        
        addGestureToChart()
        
        barChart.backgroundColor = .clear
        barChart.isUserInteractionEnabled = false
        
        // Grid
        barChart.rightAxis.enabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelTextColor = UIColor.black
        barChart.leftAxis.labelTextColor = UIColor.black
        
        // Legend
        barChart.legend.horizontalAlignment = .left
        barChart.legend.enabled = true
        barChart.legend.font = .systemFont(ofSize: 14)
        barChart.legend.textColor = UIColor.black
        
        // Label
        barChart.leftAxis.labelFont = .systemFont(ofSize: 14)
        barChart.xAxis.labelFont = .systemFont(ofSize: 14)
        barChart.leftAxis.axisMinimum = 0
        
        // Add some constraint
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        barChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -16).isActive = true
        barChart.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 16).isActive = true
        barChart.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -16).isActive = true
    }
    
}



