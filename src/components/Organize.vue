<template>
  <button type="submit" v-if="!createEventInput" @click="createEventInput = true">Create event</button>
  <button type="submit" v-if="!addCategoryInput" @click="addCategoryInput = true">Add ticket category</button>
  <div v-if="createEventInput">
    <PublishEvent @eventPublished="createEventInput=false"/>
  </div>
  <div v-if="addCategoryInput">
    <AddCategory />
  </div>
</template>

<script>
import PublishEvent from "./PublishEvent.vue"
import AddCategory from "./AddCategory.vue"

export default {
  data() {
    return {
      createEventInput: false,
      addCategoryInput: false,
    }
  },
  methods: {

  },
  components: {PublishEvent, AddCategory},
}
</script>
