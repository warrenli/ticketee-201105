class Notifier < ActionMailer::Base
  default :from => "notifications@example.com"

  def comment_updated(comment)
    @comment = comment
    recipients comment.ticket.watchers.map(&:email)
    subject "[ticketee] #{comment.ticket.project.name} - #{comment.ticket.title}"
    from "Ticketee <youraccount@example.com>"
  end
end
