module CelebrantHelper
  def celebrant_url(celebrant_id)
    "#{host}/#/user/#{celebrant_id}"
  end

  def host
    @host ||= ActionMailer::Base.default_url_options[:host]
  end
end
