<template>
  <v-layout>
    <v-flex class="text-center">
      <blockquote class="blockquote">
        It is index page.<br />
        {{ isClient }}<br />
        {{ userProfile }}<br />
        {{ occoredError }}
      </blockquote>
    </v-flex>
  </v-layout>
</template>

<script>
const liffId = process.env.MY_LIFF_ID || ''
const liff = window.liff
export default {
  data() {
    return {
      liffId: '1654370992-w7jbVe0m',
      isClient: false,
      userProfile: {},
      occoredError: '特にエラーなし'
    }
  },
  mounted() {
    liff
      .init({ liffId })
      .then(() => {
        // Start to use liff's api
        console.log('success')
        this.isClient = liff.isInClient()
        if (liff.isLoggedIn()) {
          liff
            .getProfile()
            .then((profile) => {
              this.userProfile = profile
            })
            .catch((err) => {
              this.occoredError = 'error:' + err
            })
        }
      })
      .catch((err) => {
        // Error happens during initialization
        console.log(err.code, err.message)
      })
  }
}
</script>
