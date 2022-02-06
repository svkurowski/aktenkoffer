document.addEventListener('turbo:load', () => {
  function openModal($el) {
    $el.classList.add('is-active');
  }

  function closeModal($el) {
    $el.classList.remove('is-active');
  }

  function closeAllModals() {
    (document.querySelectorAll('.modal') || []).forEach($modal => {
      closeModal($modal);
    });
  }

  const modalTogglerSelector = '[data-action="toggle-modal"]';
  document.querySelectorAll(modalTogglerSelector).forEach($trigger => {
    const modal = $trigger.dataset.target;
    const $target = document.getElementById(modal);

    $trigger.addEventListener('click', e => {
      openModal($target);
      e.preventDefault();
    });
  });

  const modalCloseSelector = '.modal-background, .modal-close, '
                                + '.modal-card-head .delete, '
                                + '.modal-card-foot .button';
  document.querySelectorAll(modalCloseSelector).forEach($close => {
    const $target = $close.closest('.modal');

    $close.addEventListener('click', () => {
      closeModal($target);
    });
  });

  // Add a keyboard event to close all modals
  document.addEventListener('keydown', event => {
    const e = event || window.event;

    if (e.keyCode === 27) { // Escape key
      closeAllModals();

      e.preventDefault();
    }
  });
});
