import UIKit

private let cellID = "MemoTableViewCell"

class ViewController: UIViewController {
    
    // MARK: - 프로퍼티
    // 1. 모델을 구성한다.
    var tableViewDataModel = [Memo(title: "메모1", content: "메모메모"),
                              Memo(title: "메모2", content: "메모메모"),
                              Memo(title: "메모3", content: "메모메모"),
                              Memo(title: "메모4", content: "메모메모"),
                              Memo(title: "메모5", content: "메모메모")]
    
    // MARK: - UI 객체
    // 2. UITableView의 UI를 생성한다.
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpLayout()
    }

    // MARK: -  Helper
    // 3. UITableView의 내용을 구성한다.
    private func setUpTableView() {
        tableView.delegate = self
        //"tableView한테 이벤트가 발생하면 프로토콜에 따라 ViewController가 tableView에게 응답을 줄게."
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID) //MemoTableViewCell이름의 XIB를 tableView에 등록한다.
    }
    private func setUpLayout() {
    }
}
    // MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate { //extension으로 따로 필수 메서드를 정리
    
    //Cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataModel.count
    }
    //Cell 구성 -> cell의 개수만큼 호출된다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = tableViewDataModel[indexPath.row]
        //ID가 cellID인 cell에 tableViewDataModel[indexPath.row]를 넣어라!
        //즉, tableView의 행을 식별하는 인덱스 경로의 행에 위치를 인덱스로 가지는 tableViewDataModel의 원소를 cellData에 넣어라.
        //indexPath는 [0, 0] [0, 1] [0, 2] [0, 3] [0, 4] 이와 같은 형식인데 여기서 indexPath.row를 뽑아내면 0, 1, 2, 3, 4가 된다. 따라서 tableViewDataModel[indexPath.0]을 cellData 상수에 저장한다.
        // 더하기) 위의 indexPath의 colunm은 Section이다. 따라서 우리가 출력한 indexPath의 Section은 0이다.
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MemoTableViewCell
        
        //dequeueReusableCell이란 지정된 재사용 식별자에 대한 재사용 가능한 테이블 뷰 셀 객체를 반환하고 이를 테이블에 추가하는 메소드입니다.
        //1. withIdentifier: string형 identifier는 재사용할 객체를 나타냄
        //2. for: 셀의 위치를 지정하는 인덱스 패스
        //3. indexPath: tableView 메소드가 받은 매개변수를 indexPath라고 한 것 / tableView의 행을 식별하는 인덱스 경로
        //equeueReusableCell을 사용하는 이유: cell을 재사용해서 메모리를 줄이기 위해서
        //as! MemoTableViewCell: 여러 class중에서 MemoTableViewCell에만 효과를 내겠다.
        
        cell.textLabel?.text = cellData.title
        
        //cell의 textLabel의 text에 cellData의 title을 넣어라.
        
        cell.detailTextLabel?.text = cellData.content
        
        //cell의 detailTextLabel의 text에 cellData의 content을 넣어라.
        
        //textLabel, detailTextLabel은 우리가 추가하지 않아도 자동으로 cell에 있는 프로퍼티이다.
        
        //요약하자면
        //1. cellData에 cell의 위치를 저장하고
        //2. cell재사용
        //3. 해당 cell의 title을 cell의 textLabel?.text에 저장
        //4. 해당 cell의 content를 cell의 detailTextLabel?.textdp wjwkd
        
        return cell
    }
    
    //cell을 클릭했는지 확인해주는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellData = tableViewDataModel[indexPath.row]
        
        //인스턴스 생성
        //스토리보드가 있다면 스토리보드의 SecondVC라는 ID를 가진 ViewViewController의 타입은 SecondViewController이다.
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        //vc의 data에 indexPath번째 data를 저장한다.
        vc.data = cellData
        
        //view 보여주기
        present(vc, animated: true, completion: nil)
        //이후 기능은 SecondViewController에서
    }
    
}

