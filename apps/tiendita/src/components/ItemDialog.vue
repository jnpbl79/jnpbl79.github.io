<script lang="ts" setup>
import type { ProductItem } from '../types';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faAngleLeft, faAngleRight, faXmark } from '@fortawesome/free-solid-svg-icons';

const props = defineProps<{
    item: ProductItem;
    imgIndex: number;
}>();

const emits = defineEmits<{
    onClose: [];
    onNext: [currentIndex: number];
    onPrev: [currentIndex: number];
}>();
</script>

<template>
    <dialog :open="item !== null" class="dialog-item">
        <article>
            <header class="dialog-header">
                <h2>{{ item.name }}</h2>
                <button class="secondary" @click="emits('onClose')">
                <FontAwesomeIcon 
                    :icon="faXmark"
                    class="dialog-icon"
                />
                </button>
            </header>
            <div class="dialog-image-container">
                <img 
                    :src="`products/${item.images[imgIndex]}`"
                    @click="emits('onNext', imgIndex)"
                    class="dialog-image" 
                />
            </div>
            <footer class="dialog-footer">
                <button @click="emits('onPrev', imgIndex)" title="Anterior">
                    <FontAwesomeIcon :icon="faAngleLeft" />
                </button>

                <button class="secondary contrast" @click="emits('onClose')" title="Cerrar">
                    <FontAwesomeIcon :icon="faXmark" />
                </button>

                <button @click="emits('onNext', imgIndex)" title="Siguiente">
                    <FontAwesomeIcon :icon="faAngleRight" />
                </button>
            </footer>
        </article>
    </dialog>
</template>

<style scoped>
.dialog-item {
    width: 90%;
    max-width: 500px;
    border: none;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 1rem;
}

.dialog-icon {
    cursor: pointer;
}

.dialog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.dialog-image {
    max-width: 100%;
    border-radius: 10px;
    margin: 1rem 0;
    cursor: pointer;
}

footer {
    display: flex;
    justify-content: center;
    gap: 1rem;
}

button {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:not(.secondary) {
    background-color: #007bff;
    color: white;
}

button:hover,
.dialog-icon:hover {
    opacity: 0.9;
}

.dialog-image-container {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>