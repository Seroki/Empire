/**
 * Valley & Resource Field Controller
 * Handles map interaction logic, network API dispatching, and view updating.
 */

import { fetchJson } from '../utils/api-client.js';

class ValleyController {
  constructor() {
    this.currentTile = null;
    this.unitCodes = ['infantry', 'cavalry', 'archer', 'siege'];
    
    this.dom = {
      content: document.getElementById('valley-detail-content'),
      actionsContainer: document.getElementById('tile-actions-container'),
      attackForm: document.getElementById('attack-troop-form'),
      troopInputs: document.getElementById('troop-inputs-list'),
      btnAttack: document.getElementById('btn-attack-tile'),
      btnRecall: document.getElementById('btn-recall-tile'),
      btnConfirmAttack: document.getElementById('btn-confirm-attack'),
      btnCancelAttack: document.getElementById('btn-cancel-attack')
    };

    this.bindEvents();
  }

  /**
   * Attach event listeners to static DOM nodes
   */
  bindEvents() {
    if (this.dom.btnAttack) {
      this.dom.btnAttack.addEventListener('click', () => this.toggleAttackForm(true));
    }
    if (this.dom.btnCancelAttack) {
      this.dom.btnCancelAttack.addEventListener('click', () => this.toggleAttackForm(false));
    }
    if (this.dom.btnConfirmAttack) {
      this.dom.btnConfirmAttack.addEventListener('click', () => this.handleAttackSubmit());
    }
    if (this.dom.btnRecall) {
      this.dom.btnRecall.addEventListener('click', () => this.handleRecallSubmit());
    }
  }

  /**
   * Fetches field state and renders information panel
   */
  async inspectTile(x, y, myCityId) {
    this.currentTile = { x, y, myCityId };
    this.toggleAttackForm(false);

    const result = await fetchJson(`/api/valley/tile/${x}/${y}`);
    if (!result || !result.success) {
      this.dom.content.textContent = 'Unable to fetch valley details.';
      this.dom.actionsContainer.classList.add('hidden');
      return;
    }

    const v = result.valley;
    const isMine = myCityId && v.owner_city_id === myCityId;

    // Build info text
    let infoHtml = `
      <div><strong>Type:</strong> ${v.field_type}</div>
      <div><strong>Level:</strong> ${v.level}</div>
      <div><strong>Owner:</strong> ${v.owner_city_id ? (isMine ? 'You' : `City #${v.owner_city_id}`) : 'Unclaimed'}</div>
    `;

    this.dom.actionsContainer.classList.remove('hidden');

    if (isMine) {
      infoHtml += `<div><strong>Accrued Harvest:</strong> ${Number(result.accruedHarvest).toLocaleString()}</div>`;
      this.dom.btnAttack.classList.add('hidden');

      if (v.recall_at) {
        infoHtml += `<div class="status-alert">Recalling troops...</div>`;
        this.dom.btnRecall.classList.add('hidden');
      } else {
        this.dom.btnRecall.classList.remove('hidden');
      }
    } else {
      this.dom.btnRecall.classList.add('hidden');
      this.dom.btnAttack.classList.remove('hidden');
    }

    this.dom.content.innerHTML = infoHtml;
    this.buildTroopInputs();
  }

  /**
   * Generates input controls dynamically into form wrapper
   */
  buildTroopInputs() {
    this.dom.troopInputs.innerHTML = '';
    this.unitCodes.forEach(code => {
      const row = document.createElement('div');
      row.className = 'form-row';
      row.innerHTML = `
        <label for="troop-input-${code}">${code.toUpperCase()}:</label>
        <input type="number" id="troop-input-${code}" data-unit="${code}" min="0" value="0" />
      `;
      this.dom.troopInputs.appendChild(row);
    });
  }

  toggleAttackForm(show) {
    if (show) {
      this.dom.attackForm.classList.remove('hidden');
      this.dom.btnAttack.classList.add('hidden');
    } else {
      this.dom.attackForm.classList.add('hidden');
      if (this.currentTile && !this.isOwnedByPlayer()) {
        this.dom.btnAttack.classList.remove('hidden');
      }
    }
  }

  isOwnedByPlayer() {
    return this.currentTile && this.currentTile.owner_city_id === this.currentTile.myCityId;
  }

  async handleAttackSubmit() {
    const { x, y, myCityId } = this.currentTile;
    const troops = {};

    this.unitCodes.forEach(code => {
      const input = document.getElementById(`troop-input-${code}`);
      troops[code] = Math.max(0, Number(input?.value || 0));
    });

    const result = await fetchJson(`/api/valley/${x}/${y}/attack`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ cityId: myCityId, troops })
    });

    if (!result || !result.success) {
      alert(`Attack failed: ${result?.error || 'Unknown error'}`);
      return;
    }

    alert(result.won ? 'Field successfully conquered!' : 'Attack failed. Forces defeated.');
    this.inspectTile(x, y, myCityId);
  }

  async handleRecallSubmit() {
    const { x, y, myCityId } = this.currentTile;

    const result = await fetchJson(`/api/valley/${x}/${y}/recall`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ cityId: myCityId })
    });

    if (!result || !result.success) {
      alert(`Recall failed: ${result?.error || 'Unknown error'}`);
      return;
    }

    alert(`Resources harvested. Troops returning to city.`);
    this.inspectTile(x, y, myCityId);
  }
}

export const valleyController = new ValleyController();
