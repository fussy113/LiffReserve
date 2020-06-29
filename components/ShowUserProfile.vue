<template>
  <div>
    {{ userProfile.displayName }}<br />
    {{ userProfile.userId }}
  </div>
</template>

<script>
export default {
  props: {
    userProfile: {
      type: Object,
      default: () => ({
        displayName: 'test',
        userId: ''
      }),
      required: false
    }
  }
}
</script>
