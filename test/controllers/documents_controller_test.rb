require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)

    login()
  end

  test 'should get index' do
    get documents_url
    assert_response :success
  end

  test 'should get new' do
    get new_document_url
    assert_response :success
  end

  test 'should create document' do
    @file = fixture_file_upload 'example.pdf'

    assert_difference('Document.count') do
      post documents_url, params: { document: { received_at: @document.received_at, recipient_id: @document.recipient_id, sender_id: @document.sender_id, sent_at: @document.sent_at, title: @document.title, original_file: @file } }
    end

    assert_redirected_to document_url(Document.order(:created_at).last)
  end

  test 'should show document' do
    get document_url(@document)
    assert_response :success
  end

  test 'should get edit' do
    get edit_document_url(@document)
    assert_response :success
  end

  test 'should update document' do
    patch document_url(@document), params: { document: { received_at: @document.received_at, recipient_id: @document.recipient_id, sender_id: @document.sender_id, sent_at: @document.sent_at, title: @document.title } }
    assert_redirected_to document_url(@document)
  end

  test 'should destroy document' do
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
