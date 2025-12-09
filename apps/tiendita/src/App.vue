<script setup lang="ts">
import { computed, ref } from 'vue';
import type { ProductItem, StoreInfo } from './types';
import data from './products.json' with { type: 'json' }
import ItemDialog from './components/ItemDialog.vue';
// import Item from './components/Item.vue';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faGrinHearts, faShop, faCat } from '@fortawesome/free-solid-svg-icons';

const priceFormatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'
});

const storeInfo: StoreInfo = data;
const products = ref<ProductItem[]>(storeInfo.items);
const selectedItem = ref<ProductItem | null>(null);
const selectedImgIndex = ref<number>(0);
const clickCounter = ref(0);

const sorted = computed(() => {
  return products.value
    .filter(p => p.display !== false)
    .sort((a, b) => b.price - a.price);
});

const filteredSold = computed(() => {
  return sorted.value.filter(p => p.sold);
});

const filteredPending = computed(() => {
  return sorted.value.filter(p => !p.sold && !p.dibs);
});

const filteredDibs = computed(() => {
  return sorted.value.filter(p => !p.sold && p.dibs);
});

const totalSold = computed(() => products.value.filter(p => p.sold).reduce((total, p) => total += p.price, 0));
const totalDibs = computed(() => products.value.filter(p => p.dibs).reduce((total, p) => total += p.price, 0));
const totalPending = computed(() => products.value
  .filter(p => !p.sold && !p.dibs && p.display !== false)
  .reduce((total, p) => total += p.price, 0)
);
const total = computed(() => totalDibs.value + totalPending.value + totalSold.value);

function formatPrice(price: number): string {
  return priceFormatter.format(price).split('.')[0] || '';
}

function selectItem(item: ProductItem, imgIndex: number) {
  selectedItem.value = item;
  selectedImgIndex.value = imgIndex;
  console.log('Selected item:', item);
}

function closeDialog() {
  selectedItem.value = null;
}

function nextImage(currentIndex: number) {
  if (selectedItem.value) {
    selectedImgIndex.value = (currentIndex + 1) % selectedItem.value.images.length;
  }
}

function prevImage(currentIndex: number) {
  if (selectedItem.value) {
    selectedImgIndex.value = (currentIndex - 1 + selectedItem.value.images.length) % selectedItem.value.images.length;
  }
}
function countClick() {
  clickCounter.value += 1;
}
</script>

<template>
  <main class="container">
    <header class="header">
      <h1>
        <FontAwesomeIcon :icon="faShop" /> Articulos
      </h1>
      <a id="wapp-preview-button" target="_blank" class="wapp-btn whatsapp-button" :href="storeInfo.wa_link">
        <svg style="width: 24px; height: 24px; margin-right: 8px;" fill="currentColor" viewBox="0 0 16 16">
          <path
            d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232">
          </path>
        </svg>
        <span>Chat on WhatsApp</span>
      </a>
    </header>

    <div>
      <article class="product-item" v-for="product in sorted" :key="product.name" :class="{
        sold: !!product.sold,
        // dibs: !!product.dibs,
        hide: product.display === false
      }">
        <header class="item-header">
          <h2 class="item-header pico-color-azure-400" :class="{ 'pico-color-green-500': product.dibs }">
            {{ product.name }}
            <FontAwesomeIcon :icon="faGrinHearts" v-if="product.dibs" />
          </h2>
          <b class="item-price pico-color-azure-300" :class="{ 'pico-color-green-500': product.dibs }">{{
            formatPrice(product.price) }}</b>
        </header>
        <div>{{ product.description }}</div>
        <div class="image-container">
          <img v-for="(image, imgIndex) in product.images" class="item-image" :key="image" :src="`products/${image}`"
            @click="selectItem(product, imgIndex)" />
        </div>
      </article>
    </div>
    <footer>
      <table v-if="clickCounter > 10">
        <tbody>
          <tr>
            <th>Clicks</th>
            <td>{{ clickCounter }}</td>
          </tr>
          <tr>
            <th>Sold</th>
            <td>{{ formatPrice(totalSold) }}</td>
          </tr>
          <tr>
            <th>Dibs</th>
            <td>{{ formatPrice(totalDibs) }}</td>
          </tr>
          <tr>
            <th>Pending</th>
            <td>{{ formatPrice(totalPending) }}</td>
          </tr>
          <tr>
            <th>Total</th>
            <td>{{ formatPrice(total) }}</td>
          </tr>
        </tbody>
      </table>
      <table v-if="clickCounter > 10">
        <tbody>
          <tr>
            <th colspan="3"><strong>Sold</strong></th>
          </tr>
          <tr v-for="item in filteredSold">
            <td>{{ item.name }}</td>
            <td>{{ formatPrice(item.price) }}</td>
            <td>{{ item.sold_to }}</td>
          </tr>
          <tr>
            <td></td>
            <td><strong>{{ formatPrice(totalSold) }}</strong></td>
            <td></td>
          </tr>
          <tr>
            <th colspan="3"><strong>Dibs</strong></th>
          </tr>
          <tr v-for="item in filteredDibs">
            <td>{{ item.name }}</td>
            <td>{{ formatPrice(item.price) }}</td>
            <td>{{ item.dibs }}</td>
          </tr>
          <tr>
            <td></td>
            <td><strong>{{ formatPrice(totalDibs) }}</strong></td>
            <td></td>
          </tr>
          <tr>
            <th colspan="3"><strong>Pending</strong></th>
          </tr>
          <tr v-for="item in filteredPending">
            <td>{{ item.name }}</td>
            <td>{{ formatPrice(item.price) }}</td>
            <td></td>
          </tr>
          <tr>
            <td></td>
            <td><strong>{{ formatPrice(totalPending) }}</strong></td>
            <td></td>
          </tr>
          <tr>
            <td></td>
            <td><strong>{{ formatPrice(total) }}</strong></td>
            <td></td>
          </tr>
        </tbody>
      </table>
    </footer>
    
    <div class="button-footer">
      <FontAwesomeIcon :icon="faCat" @click="countClick" size="2x" />
    </div>
  </main>
  <ItemDialog v-if="selectedItem !== null" :item="selectedItem" :img-index="selectedImgIndex" @on-close="closeDialog"
    @on-next="nextImage" @on-prev="prevImage" />
</template>

<style>
main {
  /* max-width: 800px; */
  margin: 1rem auto;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}

/* article {
  border-radius: 10px;
} */
.product-item {
  border-radius: 10px;
  padding: 1rem;
  margin-bottom: 1.5rem;
  box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1);
  transition: box-shadow 0.3s ease;
}

/* h2 { color: aqua;} */
.product-item header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.product-item header h2 {
  font-size: 1.2rem;
  margin: 0;
}

.product-item.sold,
.product-item.hide {
  display: none;
  opacity: 0.5;
  text-decoration: line-through;
}

.product-item.dibs {
  /* border: 2px solid orange; */
  opacity: 0.65;
}

.item-image {
  max-height: 80px;
  border: 1px solid #ccc;
  border-radius: 10px;
  cursor: pointer;
}

.image-container {
  margin-top: 1rem;
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
}

.button-container {
  display: flex;
  justify-content: end;
  gap: 0.5rem;
}

.wapp-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.6em 1.2em;
  border-radius: 0.4em;
  border: none;
  font-weight: 600;
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease, box-shadow 0.3s ease;
  min-height: 44px;
  min-width: 44px;
  box-sizing: border-box;
}

.whatsapp-button {
  background-color: rgb(37, 211, 102);
  color: rgb(255, 255, 255);
  border-radius: 8px;
  bottom: 1.5em;
  right: 1.5em;
  left: auto;
}

.button-footer {
  display: flex;
  justify-content: end;
}
</style>
