# language: zh-TW

功能: 登入系統
  為了可以使用系統功能
  作為一名用戶
  我能夠登入系統

  背景:
    假設 選用 中文
    假設 有以下帳戶:
      |       email       | password | unconfirmed |
      | user@ticketee.com | password | true |

  場景: 確認新帳戶同時登入系統
    當 "user@ticketee.com"閱讀標題為"確認帳戶的指示"的電子郵件
    而且 按下電子郵件裡第一個鏈接
    那麼 我應該看到"您的帳戶已成功確認。您現在已登錄。"
    那麼 我應該看到"user@ticketee.com 經已登入"

  場景: 使用登入頁面登入系統
    假設 "user@ticketee.com"已確認帳戶
    而且 我來到首頁
    當 我點擊鏈接"登入"
    而且 在"電郵地址"欄位中輸入"user@ticketee.com"
    而且 在"帳戶密碼"欄位中輸入"password"
    而且 按下了"登入"按钮
    那麼 我應該看到"登錄成功。"
