# language: zh-TW

功能: 修改專案
  為了可以修改專案資料
  作為一名用戶
  我可以使用一個界面執行修改工作

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |       email       | password | admin |
      | user@ticketee.com | password | true  |
    而且 已成功登入系統
    假設 有一個名稱為"大中華"的專案
    而且 我來到首頁
    當 我點擊鏈接"大中華"
    而且 點擊鏈接"修改"

  場景: 修改專案資料
    而且 我在"專案名稱"欄位中輸入"大中華新天地"
    而且 按下了"更新 專案"按钮
    那麼 我應該看到"專案已修改。"
    那麼 我停留在專案"大中華新天地"

  場景: 修改專案但資料不完整
    而且 我在"專案名稱"欄位中輸入""
    而且 按下了"更新 專案"按钮
    那麼 我應該看到"未能修改專案。"
