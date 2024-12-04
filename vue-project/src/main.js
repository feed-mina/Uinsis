import './assets/main.css'
import { createApp } from 'vue';
import App from './App.vue';
import { createVuetify } from 'vuetify';
import 'vuetify/styles'; // Vuetify 스타일
import '@mdi/font/css/materialdesignicons.css'; // 아이콘 폰트

import router from "./router/index.js"; // 라우터 설정이 있다면
import store from "./store/store.js"; // 상태 관리 라이브러리


import { aliases, mdi } from "vuetify/iconsets/mdi"; // 아이콘 설정 (옵션)
import * as components from "vuetify/components"; // Vuetify 컴포넌트 등록
import * as directives from "vuetify/directives"; // Vuetify 디렉티브 등록

const vuetify = createVuetify({
    components,
    directives,
});
const app = createApp(App);

app.use(router); // 라우터 추가
app.use(store); // 상태 관리 라이브러리 추가
app.use(vuetify); // Vuetify 등록

app.mount("#app"); // #app에 마운트
// 앱 마운트하기 : 엡 인스턴스는 .mount() 메서드가 호출될때까지 아무것도 렌더링하지 않는다 컨테이너가 될 실제 DOM앨리먼트 또는 셀렉터 문자열을 인자로 필요한다.
// 앱의 최상위 컴포넌트 컨텐츠는 컨테이너 엘리먼트 내에서 렌더링된다. 컨테이너 엘리먼트 자체는 앱의 일부로 간주되지 않는다.
// .mount() 메서드는 반드시 앱의 환경설정 및 에셋이 모두 등록 완룍된 후에 호출되어야 한다. 또한 에셋 등록 메서드와 달리 반환 값은 앱 인스턴스가 아닌 최상위 컴포넌트 인스턴스이다.
// DOM 내부의 최상위 컴포넌트 템플릿 : 빌드 과정 없이 Vue를 사용할때 마운트 컨테이너 내부에 직접 최상위 컴포넌트의 템플릿을 작성할 수 있다.

// 앱 인스턴스는 동일한 페이지 내 하나로 제한되지 않는다. createApp API를 사용하면 여러 VUE앱이 동일한 페이지에 공존할 수 있으며 각각은 구성 및 전역 자산에 대한 고유한 범위를 갖는다.

// 서버에서 렌더링 된 대규모 페이지의 HTML을 개선하고 특정부분을 제어하기 위해 Vue가 필요한 경우 페이지 전체를 단일 Vue 앱 인스턴스로 마운트하지 마십시오. 대신 여러 개의 작은 앱 인스턴스를 만들고 감당해야 하는 엘리먼트에 마운트한다.

