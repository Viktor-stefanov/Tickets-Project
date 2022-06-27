<template>
    <select v-model="selectedOption">
        <option v-for="(item, index) in options" :value="item" :key="index">{{ item }}</option>
    </select>
    <button @click="func()">Click me</button>
</template>

<script>
export default {
    data() {
        return {
            options: [],
            selectedOption: null,
        };
    },
    mounted() {
        setTimeout(() => {
          this.options = [1, 2, 3];
        }, 3000)
    },
    methods: {
        func() {
            console.log(this.selectedOption);
        }
    }
};
</script>
