require 'application_system_test_case'

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
    @unused_contact = contacts(:unused)

    login()
  end

  test 'visiting the index' do
    visit documents_url
    assert_selector 'h1', text: 'Documents'
  end

  test 'creating a document' do
    visit documents_url
    click_on 'New Document'

    attach_file('Document', file_fixture('example.pdf'), make_visible: true)
    fill_in 'Received at', with: @document.received_at
    click_on 'Select Recipient'
    click_on @document.recipient.name
    click_on 'Select Sender'
    click_on @document.sender.name
    fill_in 'Received at', with: @document.received_at
    fill_in 'Sent at', with: @document.sent_at
    fill_in 'Title', with: @document.title
    click_on 'Submit'

    assert_text 'Document was successfully created'
  end

  test 'creating one document using drag and drop' do
    visit documents_url

    target = page.find('body')
    target.drop(file_fixture('example.pdf'))

    # Currently there is no notification for creation success
    assert_link 'Edit'
  end

  test 'updating a document' do
    visit documents_url
    click_on 'Show', match: :first
    click_on 'Edit', match: :one

    fill_in 'Received at', with: @document.received_at
    click_on 'Select Recipient'
    click_on @unused_contact.name
    click_on 'Select Sender'
    click_on @document.recipient.name
    fill_in 'Sent at', with: @document.sent_at
    fill_in 'Title', with: @document.title
    click_on 'Submit'

    assert_text 'Document was successfully updated'
  end

  test 'destroying a document' do
    visit documents_url
    click_on 'Show', match: :first

    click_on 'Delete', match: :one

    assert_text 'Document was successfully deleted'
  end
end
