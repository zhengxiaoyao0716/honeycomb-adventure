import React from 'react';
import PropTypes from 'prop-types';
import styles from './index.css';

import { types, connect } from './../redux';

const reverse = (text: string) => ({ type: 'hello.set', payload: { text: Array.from(text).reverse().join('') } });
const Hello = ({ text }, { dispatch }) => (<div className={styles.Banner} onClick={() => dispatch(reverse(text))}>{text}</div>);
Hello.propTypes = types.hello;
Hello.contextTypes = {
    store: PropTypes.object.isRequired,
    dispatch: PropTypes.func.isRequired,
};
export default connect(({ hello: { text } }) => ({ text }))(Hello);
