<template>
  <div>
    {{ userProfile.displayName }}
  </div>
</template>

<script>
export default {
  props: {
    userProfile: {
      type: Object,
      default: () => ({
        displayName: 'test'
      }),
      required: false
    }
  }
}
</script>
