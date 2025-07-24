import { Controller } from '@hotwired/stimulus';
import SelectContactController, { ContactSelectedEvent } from './select_contact_controller';

type Outlet<E> = E & { element: HTMLElement };

export default class extends Controller {
  static outlets = ['select-contact'];

  static values = { homeContactId: String };

  declare private homeContactIdValue: string;

  declare private selectContactOutlets: Outlet<SelectContactController>[];

  selectContactOutletConnected(_: Outlet<SelectContactController>, element: HTMLElement): void {
    element.addEventListener('contact:selected', this.handleContactSelected.bind(this) as EventListener);
  }

  handleContactSelected(event: ContactSelectedEvent): void {
    if (!event.detail) {
      throw new Error();
    }
    const selectedContactId = event.detail.contactId;
    if (selectedContactId === this.homeContactIdValue) {
      return;
    }

    if (this.selectContactOutlets.length !== 2) {
      throw new Error(`Expected exactly 2 connected select-contact outlets but found ${this.selectContactOutlets.length}`);
    }
    const otherController = this.selectContactOutlets.find(outlet => outlet.element !== event.currentTarget as Element);
    if (otherController === undefined) {
      throw new Error("Couldn't find other select-contact controller");
    }

    if (otherController.selectedContactId() === undefined) {
      otherController.selectContactById(this.homeContactIdValue);
    }
  }
}
