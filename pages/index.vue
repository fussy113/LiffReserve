<template>
  <v-layout>
    <v-flex class="text-center">
      <blockquote class="blockquote">
        It is index page.<br />
        {{ isClient }}
      </blockquote>
    </v-flex>
  </v-layout>
</template>

<script>
const liffId = process.env.MY_LIFF_ID || ''
export default {
  data() {
    return {
      isClient: true
    }
  },
  mounted() {
    window.liff.init({ liffId })
    this.isClient = window.liff.isInClient()
  }
}
</script>
