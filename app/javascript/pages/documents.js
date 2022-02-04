/* global ErrorNotification, Warning */

import Turbolinks from 'turbolinks';

document.addEventListener('turbolinks:load', () => {
  const documentForm = document.querySelector('.document-form');
  if (!documentForm) {
    return;
  }

  documentForm.addEventListener('ajax:success', event => {
    const [,, xhr] = event.detail;

    if (xhr.status === 201) {
      Turbolinks.visit(xhr.getResponseHeader('location'));
    }
  });

  documentForm.addEventListener('ajax:error', event => {
    const [,, { status }] = event.detail;

    if (status === 422) {
      new ErrorNotification('Sending incorrect data, huh?').render();
      return;
    }

    if (status === 500) {
      new Warning('Something went wrong... Please try again later.').render();
    }
  });
});
