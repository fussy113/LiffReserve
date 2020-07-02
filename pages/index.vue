<template>
  <v-row>
    <v-col cols="12">
      <show-user-profile :user-profile="userProfile" />
      choiceNum:{{ choiceNum }}
      {{ occoredError }}
      <select-number
        :select-liff-line="selectLiffLile"
        @input="choiceNum = $event"
      />
      <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            v-show="choiceNum"
            color="red
            lighten-2"
            v-bind="attrs"
            v-on="on"
            @click="sendRequest"
          >
            Send
          </v-btn>
        </template>
        <v-card>
          <v-card-title class="headline blue lighten-2" primary-title>
            accept!
          </v-card-title>

          <v-card-text>
            <p class="display-1 text--primary">please close btn</p>
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
    </v-col>
  </v-row>
</template>

<script>
import ShowUserProfile from '~/components/ShowUserProfile'
import SelectNumber from '~/components/SelectNumber'
const liffId = process.env.MY_LIFF_ID || ''
const liff = window.liff
export default {
  components: {
    ShowUserProfile,
    SelectNumber
  },
  data() {
    return {
      isClient: false,
      dialog: false,
      userProfile: {
        displayName: 'test',
        userId: 'test'
      },
      selectLiffLile: {
        label: 'LIFF、触ってみてどうでしたか？',
        selects: {
          1: {
            id: '1',
            label: '最高'
          },
          2: {
            id: '2',
            label: 'もうこれしか使えない'
          },
          3: {
            id: '3',
            label: '夢が広がった'
          }
        }
      },
      choiceNum: '',
      occoredError: ''
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
          choice_num: this.choiceNum,
          created_at: this.$dayjs().format('YYYY/MM/DD HH:mm:ss')
        }
      }
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
