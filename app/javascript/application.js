// Entry point for the build script in your package.json

import * as ActiveStorage from '@rails/activestorage';
import '@hotwired/turbo-rails';
import { Application } from '@hotwired/stimulus';
import './components/ErrorNotification';
import './components/Notification';
import './components/WarningNotification';
import './elements/modals';
import './elements/navBar';
import './elements/prepareFileDropOverlay';
import './elements/prepareFileInputs';
import './elements/tagInputs';
import './pages/documents';
import SelectContactController from './controllers/select_contact_controller';

(() => {
  ActiveStorage.start();
  window.Stimulus = Application.start();
  window.Stimulus.register('select-contact', SelectContactController);
})();
