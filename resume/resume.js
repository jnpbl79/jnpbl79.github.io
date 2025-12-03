import {
  createApp,
  ref,
} from "https://unpkg.com/vue@3/dist/vue.esm-browser.js";

const data = await fetch("resume.json").then((res) => res.json());
console.log(data);

data.work.forEach((work) => {
  const htmlIndustries = work.industries
    ?.map((i) => `<span class="industry">${i}</span>`)
    .join(", ");
  const htmlKeywords = work.keywords
    .map(
      (k) =>
        `<span class="keyword" title="${data.keywords[k] || ""}">${k}</span>`
    )
    .join(", ");
  work.htmlKeywords = htmlKeywords;
  work.htmlIndustries = htmlIndustries;
  work.kwords = work.keywords
    .map((k) => ({
      key: k,
      text: data.keywords[k]?.text || k,
      title: data.keywords[k]?.title || "",
    }))
    .sort((a, b) => a.text.localeCompare(b.text));
});

createApp({
  setup() {
    const message = ref("Hello Vue!");
    const resume = ref(data);
    const profiles = data.basics.profiles.filter((p) => p.display !== false);
    return {
      message,
      profiles,
      resume,
    };
  },
}).mount("#app");

AOS.init();
feather.replace();
