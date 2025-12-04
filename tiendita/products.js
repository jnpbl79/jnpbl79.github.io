import { createApp, ref } from "https://unpkg.com/vue@3/dist/vue.esm-browser.js";
import data from './products.json' with { type: 'json' };

const items = data.items
  .filter(item => item.name.length > 0 && item.display !== false)
  .sort((a, b) => b.price - a.price);

const sold = data.items.filter(item => item.sold);
const hidden = data.items.filter(item => item.display === false);

const priceFormatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'
});

window.data = {
  all: data.items,
  shown: items,
  sold,
  hidden,
};

const formatPrice = (price) => priceFormatter.format(price).split('.')[0];

createApp({
  setup() {
    const title = ref(data.title);
    const wa_link = ref(data.wa_link);
    const selectedItem = ref(null);
    const selectedImgIndex = ref(0);

    const showDialog = () => document.getElementById("myDialog").showPopover();
    const hideDialog = () => document.getElementById("myDialog").close();
    const selectItem = (item, imgIndex = 0) => {
      selectedItem.value = item;
      selectedImgIndex.value = imgIndex % item.images.length;
      document.getElementById("myDialog").showModal();
      console.log("Selected item:", item, "Image index:", imgIndex);
    };

    return {
      title,
      wa_link,
      items,
      formatPrice,
      selectedItem,
      selectedImgIndex,
      selectItem,
      showDialog,
      hideDialog,
      nextImage: () => selectedImgIndex.value = (selectedImgIndex.value + 1) % selectedItem.value.images.length,
      prevImage: () => selectedImgIndex.value = (selectedImgIndex.value - 1 + selectedItem.value.images.length) % selectedItem.value.images.length,
    };
  },
}).mount("#app");

window.showSold = () => {document.querySelector('.vendido').style.display = 'block';};
window.hideSold = () => {document.querySelector('.vendido').style.display = 'none';};
  
