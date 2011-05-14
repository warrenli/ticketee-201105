# language: zh-TW

功能: 隱藏專案鏈接
  為了提供清晰的用戶功能
  作為一名用戶
  我須要系統必須隱藏用戶不能啟動的鏈接

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |       email        | password | admin |
      | user@ticketee.com  | password | false |
      | admin@ticketee.com | password | true  |
    而且 有一個名稱為"大中華"的專案
    而且 "user@ticketee.com"可以閱讀"大中華"專案

  場景: 隱藏"新專案"鏈接給已登入的一般帳戶
    假設 我以"user@ticketee.com"登入系統
    那麼 我應該不會看到"新專案"鏈接

  場景: 顯示"新專案鏈"接給已登入的管理員
    假設 我以"admin@ticketee.com"登入系統
    那麼 我應該看到"新專案"鏈接

  場景: 隱藏"修改"專案鏈接給已登入的一般帳戶
    假設 我以"user@ticketee.com"登入系統
    當 我點擊鏈接"大中華"
    那麼 我應該不會看到"修改"鏈接

  場景: 顯示"修改"專案鏈接給已登入的管理員
    假設 我以"admin@ticketee.com"登入系統
    當 我點擊鏈接"大中華"
    那麼 我應該看到"修改"鏈接

  場景: 隱藏"刪除"專案鏈接給已登入的一般帳戶
    假設 我以"user@ticketee.com"登入系統
    當 我點擊鏈接"大中華"
    那麼 我應該不會看到"刪除"鏈接

  場景: 顯示"刪除"專案鏈接給已登入的管理員
    假設 我以"admin@ticketee.com"登入系統
    當 我點擊鏈接"大中華"
    那麼 我應該看到"刪除"鏈接
