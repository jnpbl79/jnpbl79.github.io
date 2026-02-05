<script setup lang="ts">
import { ref } from 'vue';
import resume from '../../../resume/resume.json' with { type: 'json' }
import { WorkItem, IProfile } from './types';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faShop, faCat, faGlobe } from '@fortawesome/free-solid-svg-icons';

const DOWNLOADURL = "/resume_pablo_lopez.pdf"
const basics = ref(resume.basics);
const profiles = resume.profiles.filter((p) => p.display !== false);
const languages = ref(resume.languages);
const _keywords = ref(resume.keywords);
const work: any = resume.work.filter((w) => w.display !== false);
work.forEach(i => i.showDescription = i.id == 'toptal')
const workItems = ref(work);
console.log(workItems.value);

const shortDateFormatter = new Intl.DateTimeFormat('en-US', {
  year: 'numeric',
  month: 'short',
});

const formatDate = (dateString: string) => {
  if (!dateString) return 'Present';
  const date = new Date(dateString);
  return shortDateFormatter.format(date);
};

const formatDates = (startDate: string, endDate: string) => {
  return `${formatDate(startDate)} - ${formatDate(endDate)}`;
};

const printKeywords = (keywords: string[]) => {
  return keywords.map(k => _keywords.value[k]?.text || k).join(', ');
};
</script>

<template>
  <main class="resume col-lg-8 mx-auto p-4 py-md-6">
    <header className="d-flex flex-wrap justify-content-between align-items-center pb-3 border-bottom">
      <div className="d-flex flex-row align-items-center">
        <img src="/img/profile.jpg" :alt="`Picture of ${basics.name}`" width="64" height="64"
          class="rounded-circle me-3" />
        <span className="d-flex flex-column mb-3 mb-md-0 me-md-auto text-decoration-none">
          <span className="fs-2">{{ basics.name }}</span>
          <!-- <span class="text-muted">{{ basics.locationString }}</span> -->
          <div class="d-flex gap-3 d-print-none">
            <a v-for="p in profiles" :key="p.network" :href="p.url" :title="p.network"
              class="link-body-emphasis text-decoration-none" target="_blank" rel="noopener">
              <i :class="p.faIcon"></i>
            </a>
          </div>
        </span>
      </div>
      <ul class="nav nav-pills d-print-none">
        <li className="nav-item">
          <a :href="DOWNLOADURL" class="nav-link active" title="Download" target="_blank">
            Download
          </a>
        </li>
      </ul>
    </header>

    <h1 class="visually-hidden">{{ basics.name }} - Resume</h1>
    <section aria-label="Summary">
      <div class="d-flex justify-content-between mb-3">
        <h2>{{ basics.label }}</h2>
        <div class="d-flex align-items-center gap-2 mb-1">
          <div v-for="l in languages" :key="l.language" class="text-center">
            <span class="border rounded-pill px-3 py-2 text-muted" :title="`${l.language} - (${l.fluency})`">{{
              l.language }}</span>
          </div>
        </div>
      </div>
      <div class="d-flex">
        <p class="d-flex-grow-1">{{ basics.summary }}</p>
        <div class="ms-3 d-none d-print-block">
          <div class="d-flex flex-wrap gap-1">
            <div v-for="p in profiles" class="text-nowrap" :key="p.network">
              <i :class="p.faIcon"></i>
              <span class="ms-2">{{ p.username }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section aria-label="Experience">
      <h2>Experience</h2>
      <div class="row mt-3" >
        <article v-for="item in work" :key="item.id" 
          class="work-item" 
          :class="{ 'col-12 mb-3': item.full, 'work-item-short': !item.full }">
          <div class="d-flex justify-content-between my-2 flex-wrap">
            <h3 class="" :class="{ 'fs-4 me-2': item.full, 'fs-5 me-1': !item.full }">
              <span v-if="!item.url">{{ item.company }}</span>
              <a v-else :href="item.url" target="_blank" rel="noopener" class="work-title">{{ item.company }}</a>
              <sub v-if="item.via" class="fw-light text-muted ms-2"><small>via
                  <span v-if="item.viaUrl"><a :href="item.viaUrl" target="_blank" rel="noopener" class="via">{{ item.via
                      }}</a></span>
                  <span v-else>{{ item.via }}</span>
                </small></sub>
            </h3>
            <div class="fw-light">{{ formatDates(item.dateStart, item.dateEnd) }}</div>
          </div>
          <p v-if="item.showDescription">{{ item.description }}</p>
          <p v-if="item.summary.length > 0" v-for="summary in item.summary">
            {{ summary }}
            <small v-if="!item.full" class="fst-italic text-muted">{{ printKeywords(item.keywords) }}</small>
          </p>
          <ul v-if="item.highlights && item.showHighlights">
            <li v-for="highlight in item.highlights">
              {{ highlight }}
            </li>
          </ul>
          <div class="d-print-none" v-if="item.full">
            <div class="d-flex flex-wrap gap-1">
              <span v-for="k in item.keywords" :key="k" :title="_keywords[k]?.title || k"
                class="keyword border rounded-pill px-2 py-1 text-nowrap">{{ _keywords[k]?.text || k }}</span>
            </div>
          </div>
          <div class="d-none d-print-block" v-if="item.full">
            <small><i>{{ printKeywords(item.keywords) }}</i></small>
          </div>
        </article>
      </div>
    </section>

    <div>
    </div>

    <footer class="pt-2 text-muted border-top mt-3">
      <div class="d-flex flex-wrap justify-content-between">
        <div class="align-self-center">
          <i>{{ formatDate(resume.lastUpdated) }}</i>
        </div>
        <ul class="nav nav-pills d-print-none me-sm-5 me-lg-0">
          <li class="nav-item" v-for="p in profiles" :key="p.network">
            <a :href="p.url" :title="p.network" class="nav-link link-body-emphasis" target="_blank" rel="noopener">
              <i :class="p.faIcon"></i>
            </a>
          </li>
        </ul>
      </div>
    </footer>
  </main>

</template>
