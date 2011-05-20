class Notifier < ActionMailer::Base
  default :from => "notifications@example.com"

  def comment_updated(comment)
    @comment = comment
    users = comment.ticket.watchers - [comment.user]
    project_id = comment.ticket.project_id
    ticket_id = comment.ticket_id
    from_address = "Ticketee <ticketee+#{project_id}+#{ticket_id}@gmail.com>"

    mail(:to => users.map(&:email),
         :subject => "[ticketee] #{comment.ticket.project.name} - " +
                     "#{comment.ticket.title}",
         :from => from_address) do |format|
      format.text
      format.html
    end
  end
end
