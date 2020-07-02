<template>
  <v-row>
    <v-col col="12">
      name:{{ userProfile.displayName }}<br />
      userId:{{ userProfile.userId }}
    </v-col>
  </v-row>
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
