# language: zh-TW

功能: 設定基本資料
  為了預先設置資料庫內的基本資料
  作為一名系統管理員
  我可以執行工作去設定基本資料

  場景:
    假設 選用 中文
    假設 我去設定基本資料
    而且 我以"admin@ticketee.com"登入系統
    當 我點擊鏈接"Ticketee Beta"
    而且 我點擊鏈接"新工作單"
    而且 在"標題"欄位中輸入"工作單回應的狀態"
    而且 在"明細"欄位中輸入"工作單回應可以設定狀態"
    而且 按下了"建立 工作單"按钮
    那麼 我應該看到"New" 包含在"#comment_state_id"
    那麼 我應該看到"Open" 包含在"#comment_state_id"
    那麼 我應該看到"Closed" 包含在"#comment_state_id"
