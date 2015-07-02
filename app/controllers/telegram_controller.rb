class TelegramController < ApplicationController
  def update
    logger.info params.inspect
    render text: "", status: 200
  end
end
