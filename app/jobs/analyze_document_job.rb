class AnalyzeDocumentJob < ApplicationJob
  queue_as :default

  def perform(document)
    document.original_file.open do |file|
      original_file_content, status = Open3.capture2('pdftotext', file.path, '/dev/stdout')
      raise 'An error occurred while running pdftotext' unless status.exited? && status.exitstatus.zero?

      document.content = original_file_content
      document.save!
    end
  end
end
