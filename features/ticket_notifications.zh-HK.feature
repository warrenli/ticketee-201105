# language: zh-TW

功能: 工作單的更改通知
  為了知道工作單的最新資訊
  作為一名用戶
  我可以訂閱工作單、收取工作單的更改通知

  背景:
    假設 選用 中文

    假設 有以下帳戶:
      |      email        | password |
      | alice@ticketee.com | password |
      | bob@ticketee.com   | password |

    假設 電子郵件隊列沒有任何郵件

    假設 有一個名稱為"大中華"的專案
    而且 "alice@ticketee.com"可以閱讀"大中華"專案
    而且 "bob@ticketee.com"可以閱讀"大中華"專案
    而且 "alice@ticketee.com"給這個專案建立以下工作單:
      |     title     |         description          |
      |   生效日期    |  將會在下星期內盡快通知各位  |

    假設 我以"bob@ticketee.com"登入系統
    假設 我來到首頁

  場景: 工作單的作者自動訂閱工作單的最新資訊
    當 我點擊鏈接"大中華"
    而且 我點擊鏈接"生效日期"
    而且 在"回應內容"欄位中輸入"是否僧延遲"
    而且 按下了"建立 回應"按钮

    那麼 "alice@ticketee.com"應該收到1封電子郵件
    當 "alice@ticketee.com"打開電子郵件
    # 那麼 打開當前的電子郵件
    那麼 在電子郵件裡中應該寫着"剛更新了 大中華 的工作單 生效日期" 
    那麼 應該發現電子郵件標題為"[ticketee] 大中華 - 生效日期"
    而且 該郵件包含2個部分
    而且 應該有一部分content type是"text/plain"
    而且 應該有一部分content type是"text/html"

    # 當 按下電子郵件裡第一個鏈接
    當 我點擊電子郵件裡鏈接"這個網址瀏覽這工作單"
    那麼 我應該在"大中華"的工作單"生效日期"頁面
