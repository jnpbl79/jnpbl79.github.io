import {
  createApp,
  ref,
} from "https://unpkg.com/vue@3/dist/vue.esm-browser.js";

const data = await fetch("products.json").then((res) => res.json());
const items = data.items.filter(item => item.name.length > 0 && item.display !== false);
console.log(items);

const priceFormatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'
});

const formatPrice = (price) => priceFormatter.format(price).split('.')[0];

const initLightbox = () => {
  const lightbox = document.getElementById("lightbox");
  const lightboxContent = document.getElementById("lightbox-content");
  const lightboxClose = document.getElementById("lightbox-close");
  const triggers = document.querySelectorAll(".lightbox-trigger");
  triggers.forEach(trigger => {
    trigger.addEventListener("click", () => {
      lightboxContent.src = trigger.src;
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

