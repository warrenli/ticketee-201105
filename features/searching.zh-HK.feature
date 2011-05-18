# language: zh-TW

功能: 搜尋
  為了找到個別工作單
  作為一名用戶
  我可以輸人搜尋關鍵字便可以取得有關的工作單

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |      email        | password |
      | user@ticketee.com | password |
    而且 已成功登入系統
    而且 有一個名稱為"大中華"的專案
    而且 "user@ticketee.com"可以閱讀"大中華"專案
    而且 "user@ticketee.com"可以標籤"大中華"專案
    而且 "user@ticketee.com"給這個專案建立以下工作單:
      |  title  |       description     |    tags   | state |
      |  標籤01 | 工作單第一個測試標籤  | 你好嗎_1  | Open  |
    而且 "user@ticketee.com"給這個專案建立以下工作單:
      |  title  |       description     |    tags   | state  |
      |  標籤02 | 工作單第二個測試標籤  | 你好嗎_2  | Closed |
    假設 我來到首頁
    當 我點擊鏈接"大中華" 包含在"#projects"

  場景: 使用標籤搜尋工作單
    # 那麼 顯示完整網頁
    當 在"搜尋"欄位中輸入"tag:你好嗎_1"
    而且 按下了"搜尋"按钮
    那麼 我應該看到"標籤01"
    而且 我應該不會看到"標籤02"
    # 而且 顯示完整網頁

  場景: 使用狀態搜尋工作單
    當 在"搜尋"欄位中輸入"state:Open"
    而且 按下了"搜尋"按钮
    那麼 我應該看到"標籤01"
    而且 我應該不會看到"標籤02"
