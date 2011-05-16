# language: zh-TW

功能: 建立回應
  為了可以更新工作單的進度
  作為一名用戶
  我可以給工作單建立新回應

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |       email       | password |
      | user@ticketee.com | password |
    而且 已成功登入系統
    而且 有一個名稱為"大中華"的專案
    而且 "user@ticketee.com"可以閱讀"大中華"專案
    而且 "user@ticketee.com"給這個專案建立以下工作單:
      |      title      |         description      |
      |   工作單狀態    |  可建立回應記錄工作進度  |
    假設 我來到首頁
    當 我點擊鏈接"大中華" 包含在"#projects"

  場景: 建立新回應
    當 我點擊鏈接"工作單狀態"
    而且 在"回應內容"欄位中輸入"加入新功能可以建立工作單回應。"
    而且 按下了"建立 回應"按钮
    那麼 我應該看到"新回應已成功建立"
    那麼 我應該看到"加入新功能可以建立工作單回應。" 包含在"#comments" 

  場景: 建立沒有內容的回應
    當 我點擊鏈接"工作單狀態"
    而且 按下了"建立 回應"按钮
    那麼 我應該看到"回應未能建立"
    而且 我應該看到"回應內容 不能是空白字元"
