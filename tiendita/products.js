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

const initLightbox = () => {
  const lightbox = document.getElementById("lightbox");
  const lightboxContent = document.getElementById("lightbox-content");
  const lightboxClose = document.getElementById("lightbox-close");
  const triggers = document.querySelectorAll(".lightbox-trigger");

  const cicle = (evt) => {
    const data = evt.target.dataset;
    const itemIndex = parseInt(data.itemIndex);
    const imgIndex = parseInt(data.imgIndex);
    const dataItem = items[itemIndex];
    const nextImgIndex = (imgIndex + 1) % dataItem.images.length;
    const nextImg = document.querySelector(`.lightbox-trigger[data-item-index="${itemIndex}"][data-img-index="${nextImgIndex}"]`);
    nextImg.click();
  };

  triggers.forEach(trigger => {
    trigger.addEventListener("click", () => {
      lightboxContent.src = trigger.src;
      lightboxContent.alt = trigger.alt;
      lightboxContent.dataset.itemIndex = trigger.dataset.itemIndex;
      lightboxContent.dataset.imgIndex = trigger.dataset.imgIndex;
      lightboxContent.removeEventListener("click", cicle);
      lightboxContent.addEventListener("click", cicle);
      lightbox.style.display = "block";
    });
  });

  lightboxClose.addEventListener("click", () => {
    lightbox.style.display = "none";
  });

  lightbox.addEventListener("click", (event) => {
    if (event.target === lightbox) {
      lightbox.style.display = "none";
    }
  });
};

createApp({
  setup() {
    const selectedItem = ref(null);
    const selectedImgIndex = ref(0);

    return {
      items,
      formatPrice,
    };
  },
  mounted() {
    setTimeout(() => {
      initLightbox();
    }, 500);
  },
}).mount("#app");
