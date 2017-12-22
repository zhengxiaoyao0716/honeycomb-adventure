import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { BrowserRouter as Router, Route, Redirect } from 'react-router-dom';

import { store } from './redux';
import Page, { pages } from './page';

class App extends Component {
    static childContextTypes = {
        store: PropTypes.object.isRequired,
        dispatch: PropTypes.func.isRequired,
        pushPage: PropTypes.func.isRequired,
        goBack: PropTypes.func.isRequired,
    };
    getChildContext = () => {
        const { pushPage, goBack } = this;
        return { store, dispatch: store.dispatch, pushPage, goBack };
    };
    static propTypes = {
        match: PropTypes.object.isRequired,
        history: PropTypes.object.isRequired,
    }
    state = {
        page: Page.loading,
    }
    constructor(props) {
        super(props);
        Page.from(props).then(page => this.setState({ page }));
    }
    componentWillReceiveProps(props) {
        Page.from(props).then(page => this.setState({ page }));
    }

    goBack = () => this.props.history.goBack()
    pushPage = (page, payload = {}) => {
        const search = Object.entries(payload).map(([k, v]) => `${k}=${encodeURIComponent(v)}`).join('&');
        (this.state.page == page ? this.props.history.replace : this.props.history.push)(`/${page}?${search}`);
    };

    render() {
        const { page } = this.state;
        return (<page.component />);
    }
}

const AppRouter = () => (<Router>
    <div>
        <Route exact path='/' component={() => <Redirect to={{ pathname: `/${pages.index}` }} />} />
        <Route path="/:page" component={App} />
    </div>
</Router>);
export default AppRouter;
