module TurboFlashHelper
  # Turbo Streamでフラッシュメッセージを表示するヘルパー
  #
  # @param type [Symbol] メッセージタイプ (:success, :error, :warning, :info)
  # @param message [String] 表示するメッセージ
  # @return [String] Turbo Streamのレスポンス
  def turbo_flash(type, message)
    turbo_stream.prepend "flash_messages" do
      render partial: "shared/flash_message", locals: { type: type, message: message }
    end
  end

  # 成功メッセージを表示
  def turbo_flash_success(message)
    turbo_flash(:success, message)
  end

  # エラーメッセージを表示
  def turbo_flash_error(message)
    turbo_flash(:error, message)
  end

  # 警告メッセージを表示
  def turbo_flash_warning(message)
    turbo_flash(:warning, message)
  end

  # 情報メッセージを表示
  def turbo_flash_info(message)
    turbo_flash(:info, message)
  end
end
