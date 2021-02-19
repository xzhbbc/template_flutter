class Config {
  final String baseUrl;

  const Config({
    this.baseUrl = ''
});
}

const configPro = Config(
  baseUrl: 'https://bff-merchant.myutopa.com'
);

const configPre = Config(
  baseUrl: 'https://bff-merchant-pre.myutopa.com'
);

const configTest = Config(
  baseUrl: 'https://bff-merchant-test.myutopa.com'
);

const configDev = Config(
  baseUrl: 'https://bff-merchant-dev.myutopa.com'
);

const myTest = Config(
  baseUrl: 'http://192.168.221.15:3000/'
);