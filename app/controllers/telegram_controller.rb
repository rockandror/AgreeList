class TelegramController < ApplicationController
  def update
    logger.info params.inspect
    render nothing: true, status: 200
  end
end
