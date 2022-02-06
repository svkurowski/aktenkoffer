/* global ErrorNotification, Warning */

import { Turbo } from '@hotwired/turbo-rails';

document.addEventListener('turbo:load', () => {
  const documentForm = document.querySelector('.document-form');
  if (!documentForm) {
    return;
  }

  documentForm.addEventListener('turbo:submit-end', event => {
    const { detail: { fetchResponse: { response } } } = event;
    const { status } = response;
    if (status === 201) {
      Turbo.visit(response.headers.get('location'));
    } else if (status === 422) {
      new ErrorNotification('Sending incorrect data, huh?').render();
    } else {
      new Warning('Something went wrong... Please try again later.').render();
    }
  });
});
