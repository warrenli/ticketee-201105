# language: zh-TW

功能: 訂閱工作單
  為了知道工作單的最新資訊
  作為一名用戶
  我可以訂閱工作單、收取工作單的更改通知

  背景:
    假設 選用 中文

    假設 有以下帳戶:
      |      email        | password |
      | user@ticketee.com | password |
    假設 有一個名稱為"大中華"的專案
    而且 "user@ticketee.com"可以閱讀"大中華"專案
    而且 "user@ticketee.com"給這個專案建立以下工作單:
      |     title     |         description          |
      |   生效日期    |  將會在下星期內盡快通知各位  |

    假設 我以"user@ticketee.com"登入系統
    假設 我來到首頁

  場景: 切換工作單的訂閱服務
    當 我點擊鏈接"大中華"
    而且 我點擊鏈接"生效日期"
    那麼 我應該看到"user@ticketee.com" 包含在"#watchers"
    而且 按下了"停止訂閱這工作單"按钮
    那麼 我應該看到"已停止訂閱工作單"
    那麼 我應該不會看到"user@ticketee.com" 包含在"#watchers"

    而且 按下了"訂閱這工作單"按钮
    那麼 我應該看到"訂閱工作單已生效"
    那麼 我應該看到"user@ticketee.com" 包含在"#watchers"
