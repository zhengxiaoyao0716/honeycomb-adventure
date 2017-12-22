const Page = (name: string, title: string, page: Promise, component?) => ({
    name, title, component,
    toString() { return name; },
    get promise() {
        return page.then(page => {
            page && (this.component = page.default);
            return this;
        });
    },
});
const loading = Page('loading', '加载中', Promise.resolve(), require('./Loading').default);

export const pages = {
    get index() { return this.hello; },
    loading,
    hello: Page('hello', '欢迎', import('./Hello')),
    _404: Page('_404', '页面未找到', import('./_404')),
};

export default {
    loading,
    from(payload) {
        return do {
            if (typeof (payload) == 'string') {
                (pages[payload] || pages._404).promise;
            } else {
                this.from(payload.match.params.page);
            }
        };
    },
};
