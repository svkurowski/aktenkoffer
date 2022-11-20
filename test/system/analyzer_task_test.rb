require 'application_system_test_case'

class AnalyzerTaskTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
    @unused_contact = contacts(:unused)

    Aktenkoffer::Application.load_tasks
  end

  test 'triggering the task' do
    assert_enqueued_jobs 0
    assert_enqueued_with(job: AnalyzeDocumentJob, args: [@document]) do
      Rake::Task['analyzer:backfill'].invoke
    end
    assert_enqueued_jobs 1
  end
end
