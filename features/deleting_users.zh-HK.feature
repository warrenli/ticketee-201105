# language: zh-TW

功能: 刪除用戶
  為了可以刪除不須要的用戶
  作為一名管理員
  我可以將不須要的用戶刪除

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |       email        | password | admin |
      | admin@ticketee.com | password | true  |
      | user@ticketee.com  | password | false |
    而且 我以"admin@ticketee.com"登入系統
    當 我來到首頁
    而且 我點擊鏈接"管理員主頁"
    而且 我點擊鏈接"帳戶"

  場景: 刪除一個用戶
    而且 我點擊鏈接"user@ticketee.com"
    當 我點擊鏈接"刪除"
    那麼 我應該看到"帳戶已刪除。"

  場景: 不可以刪除自已帳戶
    當 我點擊鏈接"admin@ticketee.com"
    而且 我點擊鏈接"刪除"
    那麼 我應該看到"不可以刪除自已帳戶。"
