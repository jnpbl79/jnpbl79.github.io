<script setup lang="ts">
import {  ref } from 'vue';
import resume from '../../../resume/resume.json' with { type: 'json' }
import { WorkItem } from './types';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faShop, faCat } from '@fortawesome/free-solid-svg-icons';

const basics = ref(resume.basics);
const work: any = resume.work;
work.forEach(i => i.showDescription = i.id == 'toptal')
const workItems = ref(work);
console.log(workItems.value);
</script>

<template>
  <main class="container">
    <header class="header">
      <h1>
        {{ basics.name }}
      </h1>
      
    </header>
    <section>
      <h2>{{ basics.label }}</h2>
      <p>{{ basics.summary }}</p>
    </section>
    <section>
      <h3>Experience</h3>
      <article class="workitem" v-for="item in workItems">
        <div class="workitem-header">
        <h4>{{ item.company }}</h4>
        </div>
        <p v-if="item.showDescription">{{ item.description }}</p>
        <p v-if="item.summary.length > 0" v-for="summary in item.summary">
          {{ summary }}
        </p>
        <ul v-if="item.highlights">
          <li v-for="highlight in item.highlights">
            {{ highlight }}
          </li>
        </ul>
      </article>
    </section>
    <div>
    </div>
    <footer>
      
    </footer>
  </main>
  
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
  border-bottom: solid 1px;
}

.workitem-header {
  display: flex;
  justify-content: space-between;
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
