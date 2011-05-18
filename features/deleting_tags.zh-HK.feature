# language: zh-TW

功能: 刪除工作單的標籤
  為了刪除已無效用凡工作單標籤
  作為一名用戶
  我只要在標籤旁選擇刪除鏈接便可以刪除這標籤

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
      |   title  |      description     |   tags     |
      | 測試標籤 | 工作單有一個測試標籤 | 工作單標籤 |
    假設 我來到首頁
    當 我點擊鏈接"大中華" 包含在"#projects"
    而且 點擊鏈接"測試標籤"

  @javascript
  場景: 刪除工作單標籤
    而且 我點擊鏈接"delete-工作單標籤"
    那麼 我應該不會看到"工作單標籤"
