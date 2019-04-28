require 'rails_helper'

describe TaskMailer, type: :mailer do
  let(:task) { FactoryBot.create(:task, name: 'メイラーSpecを書く', description: '送信したメールの内容を確認します')}

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type = 'text/plain'; charset='utf-8' }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type = 'text/html'; charset='utf-8' }
    part.body.raw_source
  end

  describe '#creation_mail' do
    let(:mail) { TaskMailer.creation_email(task) }

    it '想定どおりのメールが生成される' do
      # ヘッダ
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])

      # text形式の本文
      expect(text_body).to match('以下のタスクを作成しました')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信したメールの内容を確認します')
    end
  end

end
