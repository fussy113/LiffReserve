<template>
  <v-layout>
    <v-flex class="text-center">
      <blockquote class="blockquote">
        It is index page.<br />
        {{ isClient }}<br />
        <show-user-profile :user-profile="userProfile" />
        {{ occoredError }}
      </blockquote>
      <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            color="red
            lighten-2"
            dark
            v-bind="attrs"
            v-on="on"
            @click="sendRequest"
          >
            Send
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline grey lighten-2" primary-title>
            accept!
          </v-card-title>

          <v-card-text>
            please close btn
          </v-card-text>

          <v-divider></v-divider>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click="closeLiffWindow">
              close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-flex>
  </v-layout>
</template>

<script>
import ShowUserProfile from '~/components/ShowUserProfile'
import SelectNumber from '~/components/SelectNumber'
const liffId = process.env.MY_LIFF_ID || ''
const liff = window.liff
export default {
  components: {
    ShowUserProfile
  },
  data() {
    return {
      isClient: false,
      dialog: false,
      userProfile: {
        displayName: 'test',
        userId: 'test'
      },
      choiceNo: 0,
      occoredError: '特にエラーなし'
    }
  },
  mounted() {
    liff
      .init({ liffId })
      .then(() => {
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
        this.occoredError = 'error:' + err
      })
  },
  methods: {
    async sendRequest() {
      const postData = {
        reserve_data: {
          user_id: this.userProfile.userId,
          choice_no: this.choiceNo,
          created_at: this.$dayjs().format('YYYY/MM/DD HH:mm:ss')
        }
      }
      console.log(postData)
      const response = await this.$axios.$post(
        this.$axios.defaults.baseURL,
        postData
      )
      if (response.statusCode !== 200) {
        this.occoredError = response
      }
    },
    closeLiffWindow() {
      liff.closeWindow()
    }
  }
}
</script>
