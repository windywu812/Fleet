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
    
    var isOnYear: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    func add(_ x: Int) -> Date {
        let cal = Calendar.current
        
        return cal.date(byAdding: .day, value: x, to: Date())!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setChartWeekly()
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
            infoProgress.text = "Weekly Summary"
            setChartWeekly()
        } else if sender.selectedSegmentIndex == 1 {
            isOnYear.toggle()
            infoProgress.text = "Anually Summary"
            setChartAnually()
        }
    }
    
    func setupView() {
         segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
         chartView.backgroundColor = .white
         addShadow(chartView)
         setUpChart()
     }
     
     func addShadow(_ view: UIView) {
         view.layer.cornerRadius = 16
         view.layer.shadowColor = UIColor.black.cgColor
         view.layer.shadowRadius = 20
         view.layer.shadowOpacity = 0.15
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
        barChart.legend.horizontalAlignment = .center
        barChart.legend.enabled = false
        
        // Label
        barChart.leftAxis.labelFont = .systemFont(ofSize: 14)
        barChart.xAxis.labelFont = .systemFont(ofSize: 14)
        barChart.leftAxis.axisMinimum = 0
        
        // Add some constraint
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        barChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -16).isActive = true
        barChart.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 16).isActive = true
        barChart.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -16).isActive = true
    }
    
}



